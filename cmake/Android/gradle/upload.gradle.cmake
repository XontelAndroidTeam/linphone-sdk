// Project information
buildDir = 'linphone-sdk/bin'
buildscript {
    repositories {
        google()
        jcenter()
        mavenCentral()
        maven {
            url "https://plugins.gradle.org/m2/"
        }
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:7.0.2'
        classpath "org.jfrog.buildinfo:build-info-extractor-gradle:4.28.2"
    }
}

allprojects {
    repositories {
        google()
        jcenter()
    }
}

apply plugin: 'maven-publish'
apply plugin: 'com.jfrog.artifactory'
artifactory {
    contextUrl = 'http://localhost:8082/artifactory/'
    publish {
        repository {
            repoKey = 'libs-snapshot-local'
            username = 'jenkins'
            password = 'Xontel@123'
        }
        defaults {
            publications('debug', 'release')
        }
    }


def artefactGroupId = 'org.linphone'
if (project.hasProperty("legacy-wrapper")) {
    artefactGroupId = artefactGroupId + '.legacy'
}
if (project.hasProperty("tunnel")) {
    artefactGroupId = artefactGroupId + '.tunnel'
}
if (project.hasProperty("no-video")) {
    artefactGroupId = artefactGroupId + '.no-video'
}
if (project.hasProperty("minimal-size")) {
    artefactGroupId = artefactGroupId + '.minimal'
}
println("AAR artefact group is: " + artefactGroupId + ", SDK version @LINPHONESDK_VERSION@")
publishing {
    publications {
        debug(MavenPublication) {
            groupId artefactGroupId
            artifactId 'linphone-sdk-android' + '-debug'
            version "@LINPHONESDK_VERSION@"
            artifact("$buildDir/outputs/aar/linphone-sdk-android-debug.aar")
            artifact source: "$buildDir/libs/linphone-sdk-android-sources.jar", classifier: 'sources', extension: 'jar'
            artifact source: "$buildDir/libs/linphone-sdk-android-javadoc.jar", classifier: 'javadoc', extension: 'jar'
            pom {
                name = 'Linphone'
                description = 'Instant messaging and voice/video over IP (VoIP) library'
                url = 'https://linphone.org/'
                licenses {
                    license {
                        name = 'GNU GENERAL PUBLIC LICENSE, Version 3.0'
                        url = 'https://www.gnu.org/licenses/gpl-3.0.en.html'
                    }
                }
                scm {
                    connection = 'scm:git:https://gitlab.linphone.org/BC/public/linphone-sdk.git'
                    url = 'https://gitlab.linphone.org/BC/public/linphone-sdk'
                }
            }
        }
        release(MavenPublication) {
            groupId artefactGroupId
            artifactId 'linphone-sdk-android'
            version "@LINPHONESDK_VERSION@"
            artifact("$buildDir/outputs/aar/linphone-sdk-android-release.aar")
            artifact source: "$buildDir/libs/linphone-sdk-android-sources.jar", classifier: 'sources', extension: 'jar'
            artifact source: "$buildDir/libs/linphone-sdk-android-javadoc.jar", classifier: 'javadoc', extension: 'jar'
            pom {
                name = 'Linphone'
                description = 'Instant messaging and voice/video over IP (VoIP) library'
                url = 'https://linphone.org/'
                licenses {
                    license {
                        name = 'GNU GENERAL PUBLIC LICENSE, Version 3.0'
                        url = 'https://www.gnu.org/licenses/gpl-3.0.en.html'
                    }
                }
                scm {
                    connection = 'scm:git:https://gitlab.linphone.org/BC/public/linphone-sdk.git'
                    url = 'https://gitlab.linphone.org/BC/public/linphone-sdk'
                }
            }
        }
    }
}
