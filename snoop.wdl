version 1.0

workflow snoop {
    call dump
    output {
        File env = dump.env
        File gcp_instance_meta = dump.gcp_instance_meta
    }
}

task dump {
    command <<<
        env > env

        curl -s http://metadata.google.internal/computeMetadata/v1/instance/ \
            -G -d recursive=true -d alt=text \
            -H "Metadata-Flavor: Google" \
                > gcp-instance-metadata

        # Always exit with success
        true
    >>>
    output {
        File env = "env"
        File gcp_instance_meta = "gcp-instance-metadata"
    }
    runtime {
        docker: "nextstrain/base:latest"
    }
}
