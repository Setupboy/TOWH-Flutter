import com.android.build.gradle.BaseExtension
import com.android.build.gradle.LibraryExtension
import org.gradle.api.tasks.compile.JavaCompile
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    if (name == "isar_flutter_libs") {
        plugins.withId("com.android.library") {
            extensions.configure<BaseExtension>("android") {
                compileSdkVersion(36)
            }
            extensions.configure<LibraryExtension>("android") {
                compileSdk = 36
                namespace = "dev.isar.isar_flutter_libs"
            }
        }
    }
}

subprojects {
    tasks.withType<JavaCompile>().configureEach {
        sourceCompatibility = "17"
        targetCompatibility = "17"
        options.compilerArgs.add("-Xlint:-options")
    }

    tasks.withType<KotlinCompile>().configureEach {
        compilerOptions.jvmTarget.set(
            org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17,
        )
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
