
import com.trueaccord.scalapb.compiler.Version.{grpcJavaVersion, scalapbVersion, protobufVersion}


lazy val targetSparkVersion = sys.props.getOrElse("spark.version", "2.1.0")

lazy val targetScalaVersion = sys.props.getOrElse("scala.version", "2.11.7")

val akkaV = "2.3.9"

val sprayV = "1.3.3"

lazy val protobufSettings = Seq(
  PB.targets in Compile := Seq(
    scalapb.gen() -> (sourceManaged in Compile).value
  ))

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
) ++ protobufSettings

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
  "io.spray" %%  "spray-json" % "1.3.2",
  // Protobuf
  "io.grpc" % "grpc-protobuf" % grpcJavaVersion,
  "io.grpc" % "grpc-stub" % grpcJavaVersion,
  "io.grpc" % "grpc-netty" % grpcJavaVersion,
  //"com.trueaccord.scalapb" %% "scalapb-runtime" % scalapbVersion % "protobuf",
  "com.trueaccord.scalapb" %% "scalapb-runtime-grpc" % scalapbVersion,
  "com.trueaccord.scalapb" %% "scalapb-json4s" % "0.3.2"
)

lazy val shadedDependencies = Seq(
  "com.chuusai" %% "shapeless" % "1.2.4"
)

lazy val shaded = project.settings(
  target := target.value / "shaded",
  libraryDependencies ++= nonShadedDependencies.map(_ % "provided"),
  libraryDependencies ++= sparkDependencies.map(_ % "provided"),
  libraryDependencies ++= shadedDependencies,
  // assembly
  assemblyShadeRules in assembly := Seq(
    ShadeRule.rename("com.google.protobuf.**" -> "org.karps.shaded.protobuf3.@1").inAll,
    ShadeRule.rename("org.json4s.**" -> "org.karps.shaded.json4s.@1").inAll,
    ShadeRule.rename("io.netty.**" -> "org.karps.shaded.io.netty.@1").inAll,
    ShadeRule.rename("com.google.common.**" -> "org.karps.shaded.com.google.common.@1").inAll,
    ShadeRule.rename("shapeless.**" -> "org.karps.shaded.shapeless.@1").inAll
  ),
  assemblyOption in assembly := (assemblyOption in assembly).value.copy(includeScala = false)
).settings(commonSettings: _*)


lazy val ks_distribution = (project).settings(
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
  spHomepage := "https://github.com/tjhunter/karps-server",
  spAppendScalaVersion := true,
  libraryDependencies := nonShadedDependencies,
  libraryDependencies ++= sparkDependencies.map(_ % "provided"),
  spShade := true,
  assemblyMergeStrategy in assembly := {
    case PathList("META-INF", "io.netty.versions.properties") => MergeStrategy.first
    case x =>
        val oldStrategy = (assemblyMergeStrategy in assembly).value
        oldStrategy(x)
  },
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
    ShadeRule.rename("org.json4s.**" -> "org.karps.shaded.json4s.@1").inAll,
    ShadeRule.rename("io.netty.**" -> "org.karps.shaded.io.netty.@1").inAll,
    ShadeRule.rename("com.google.common.**" -> "org.karps.shaded.com.google.common.@1").inAll,
    ShadeRule.rename("shapeless.**" -> "org.karps.shaded.shapeless.@1").inAll
  ),
  assemblyMergeStrategy in assembly := {
    case PathList("META-INF", "io.netty.versions.properties") => MergeStrategy.first
    case x =>
        val oldStrategy = (assemblyMergeStrategy in assembly).value
        oldStrategy(x)
  },
  assemblyOption in assembly := (assemblyOption in assembly).value.copy(includeScala = false)
).settings(commonSettings: _*)

