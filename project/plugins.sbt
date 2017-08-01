// ~/.sbt/plugins/build.sbt
//scalaVersion := "2.11.11"

resolvers += "Spark Packages repo" at "https://dl.bintray.com/spark-packages/maven/"

addSbtPlugin("org.spark-packages" %% "sbt-spark-package" % "0.2.6")

//addSbtPlugin("com.github.mpeltonen" % "sbt-idea" % "1.6.0")

addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "0.14.5")

addSbtPlugin("com.thesamet" % "sbt-protoc" % "0.99.11")

libraryDependencies += "com.trueaccord.scalapb" %% "compilerplugin" % "0.6.0"

//addSbtPlugin("com.trueaccord.scalapb" % "sbt-scalapb" % "0.5.43")
