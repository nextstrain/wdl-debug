version 1.0

workflow snoop {
    call dump
    output {
        File env = dump.env
    }
}

task dump {
    command <<<
        env > env
    >>>
    output {
        File env = "env"
    }
}
