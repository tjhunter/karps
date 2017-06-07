import sbt._
import sbt.Keys._
import sbtsparkpackage.SparkPackagePlugin.autoImport._
import sbtassembly._
import sbtassembly.AssemblyKeys._
import sbtassembly.AssemblyPlugin.autoImport.{ShadeRule => _, assembly => _, assemblyExcludedJars => _, assemblyOption => _, assemblyShadeRules => _, _}


object MyBuild extends Build {

  lazy val targetSparkVersion = sys.props.getOrElse("spark.version", "2.1.0")
  lazy val targetScalaVersion = sys.props.getOrElse("scala.version", "2.11.7")
  val akkaV = "2.3.9"
  val sprayV = "1.3.3"

  lazy val commonSettings = Seq(
    sparkVersion := targetSparkVersion,
    scalaVersion := targetScalaVersion,
    version := s"0.2.0",
    // All Spark Packages need a license
    licenses := Seq("Apache-2.0" -> url("http://opensource.org/licenses/Apache-2.0")),
    parallelExecution := false,
    scalacOptions in (Compile, doc) ++= Seq(
      "-groups",
      "-implicits",
      "-skip-packages", Seq("org.apache.spark").mkString(":"))
  )

  lazy val sparkDependencies = Seq(
    // Spark dependencies
    "org.apache.spark" %% "spark-core" % targetSparkVersion,
    "org.apache.spark" %% "spark-sql" % targetSparkVersion
  )

  lazy val nonShadedDependencies = Seq(
    "com.typesafe.scala-logging" %% "scala-logging-api" % "2.1.2",
    "com.typesafe.scala-logging" %% "scala-logging-slf4j" % "2.1.2",
    "ch.qos.logback" % "logback-classic" % "1.0.9",
    "io.spray"            %%  "spray-can"     % sprayV,
    "io.spray"            %%  "spray-routing" % sprayV,
    "com.typesafe.akka"   %%  "akka-actor"    % akkaV,
    "io.spray" %%  "spray-json" % "1.3.2"
  )

  lazy val shadedDependencies = Seq(
    "com.chuusai" %% "shapeless" % "1.2.4"
  )

  lazy val shaded = Project("shaded", file(".")).settings(
    target := target.value / "shaded",
    libraryDependencies ++= nonShadedDependencies.map(_ % "provided"),
    libraryDependencies ++= sparkDependencies.map(_ % "provided"),
    libraryDependencies ++= shadedDependencies,
    assemblyShadeRules in assembly := Seq(
      ShadeRule.rename("com.google.protobuf.**" -> "org.karps.shaded.protobuf3.@1").inAll,
      ShadeRule.rename("shapeless.**" -> "org.karps.shaded.shapeless.@1").inAll
    ),
    assemblyOption in assembly := (assemblyOption in assembly).value.copy(includeScala = false)
  ).settings(commonSettings: _*)


  lazy val distribute = Project("distribution", file(".")).settings(
    target := target.value / "distribution",
    spName := "karps/karps-server",
    credentials += Credentials(Path.userHome / ".ivy2" / ".credentials"),
    spShortDescription := "Experimental REST API to run Spark computation graphs",
    spDescription := """This is the server part for the Karps project. It provides a simple REST
                   |API to execute
                   |data pipelines with Spark in a language independent manner. It complements
                   |(on the JVM side) the Haskell bindings available in Karps.
                   |
                   |This project is only a technological preview. The API may change in the future.
                   |""".stripMargin,
    spHomepage := "https://github.com/krapsh/kraps-server",
    spAppendScalaVersion := true,
    libraryDependencies := nonShadedDependencies,
    libraryDependencies ++= sparkDependencies.map(_ % "provided"),
    spShade := true,
    assembly in spPackage := (assembly in shaded).value
  ).settings(commonSettings: _*)

  lazy val testing = Project("ks_testing", file(".")).settings(
    target := target.value / "testing",
    libraryDependencies ++= sparkDependencies.map(_ % "provided"),
    libraryDependencies ++= nonShadedDependencies,
    libraryDependencies ++= shadedDependencies,
    // Do not attempt to run tests when building the assembly.
    test in assembly := {},
    // Spark has a dependency on protobuf2, which conflicts with protobuf3.
    // Our own dep needs to be shaded.
    assemblyShadeRules in assembly := Seq(
      ShadeRule.rename("com.google.protobuf.**" -> "org.tensorframes.protobuf3shade.@1").inAll,
      ShadeRule.rename("shapeless.**" -> "org.karps.shaded.shapeless.@1").inAll
    ),
    assemblyOption in assembly := (assemblyOption in assembly).value.copy(includeScala = false)
  ).settings(commonSettings: _*)

}