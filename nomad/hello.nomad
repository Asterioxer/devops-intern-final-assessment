job "hello-devops" {
  datacenters = ["dc1"]
  type        = "batch"

  meta {
    purpose = "demo-batch-job"
  }

  group "hello-group" {
    count = 1

    task "hello-task" {
      driver = "docker"

      config {
        image = "hello-devops:1.0.0"
      }

      resources {
        cpu    = 100
        memory = 128
      }

      restart {
        attempts = 0
        mode     = "fail"
      }

      logs {
        max_files     = 5
        max_file_size = 10
      }
    }
  }
}
