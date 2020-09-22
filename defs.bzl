"""
buildfarm definitions that can be imported into other WORKSPACE files
"""

load("@rules_jvm_external//:defs.bzl", "maven_install")

load("@remote_apis//:repository_rules.bzl", "switched_rules_by_language")

load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)

load("@io_grpc_grpc_java//:repositories.bzl", "grpc_java_repositories")

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

IO_NETTY_MODULES = [
    "buffer",
    "codec",
    "codec-http",
    "codec-http2",
    "codec-socks",
    "common",
    "handler",
    "handler-proxy",
    "resolver",
    "transport",
    "transport-native-epoll",
    "transport-native-kqueue",
    "transport-native-unix-common",
]

IO_GRPC_MODULES = [
    "api",
    "auth",
    "core",
    "context",
    "netty",
    "stub",
    "protobuf",
    "testing",
    "services",
]

def buildfarm_init(name="buildfarm"):
    """
    Initialize the WORKSPACE for buildfarm-related targets
    
    Args:
      name: the name of the repository
    """
    maven_install(
        artifacts = [
            "com.amazonaws:aws-java-sdk-autoscaling:1.11.729",
            "com.amazonaws:aws-java-sdk-core:1.11.729",
            "com.amazonaws:aws-java-sdk-ec2:1.11.729",
            "com.amazonaws:aws-java-sdk-secretsmanager:1.11.729",
            "com.amazonaws:aws-java-sdk-sns:1.11.729",
            "com.amazonaws:aws-java-sdk-ssm:1.11.729",
            "com.fasterxml.jackson.core:jackson-databind:2.9.8",
            "com.github.jnr:jnr-constants:0.9.9",
            "com.github.jnr:jnr-ffi:2.1.7",
            "com.github.jnr:jffi:1.2.16",
            "com.github.jnr:jffi:jar:native:1.2.16",
            "com.github.jnr:jnr-posix:3.0.53",
            "com.github.pcj:google-options:1.0.0",
            "com.github.serceman:jnr-fuse:0.5.1",
            "com.google.auth:google-auth-library-credentials:0.9.1",
            "com.google.auth:google-auth-library-oauth2-http:0.9.1",
            "com.google.code.findbugs:jsr305:3.0.1",
            "com.google.errorprone:error_prone_core:0.92",
            "com.google.errorprone:error_prone_annotations:2.2.0",
            "com.google.guava:guava:28.2-jre",
            "com.google.guava:failureaccess:1.0.1",
            "com.google.j2objc:j2objc-annotations:1.1",
            "com.google.jimfs:jimfs:1.1",
            "com.google.protobuf:protobuf-java:3.10.0",
            "com.google.protobuf:protobuf-java-util:3.10.0",
            "com.google.truth:truth:0.44",
        ] + ["io.netty:netty-%s:4.1.38.Final" % module for module in IO_NETTY_MODULES]
          + ["io.grpc:grpc-%s:1.26.0" % module for module in IO_GRPC_MODULES]
          + [
            "junit:junit:4.12",
            "org.apache.commons:commons-pool2:2.4.3",
            "org.checkerframework:checker-qual:2.5.2",
            "org.mockito:mockito-core:2.25.0",
            "org.openjdk.jmh:jmh-core:1.23",
            "org.openjdk.jmh:jmh-generator-annprocess:1.23",
            "org.threeten:threetenbp:1.3.3",
            "org.xerial:sqlite-jdbc:3.31.1",
        ],
        repositories = [
            "https://repo.maven.apache.org/maven2",
            "https://jcenter.bintray.com",
        ],
    )

    switched_rules_by_language(
        name = "bazel_remote_apis_imports",
        java = True,
    )

    container_repositories()

    protobuf_deps()

    grpc_java_repositories()

    native.bind(
        name = "jar/redis/clients/jedis",
        actual = "@jedis//jar",
    )
