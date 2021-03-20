job "invoicify" {
  datacenters = ["dc1"]
  type = "service"

  update {
    max_parallel = 1
    min_healthy_time = "10s"
    healthy_deadline = "3m"
    progress_deadline = "10m"
    auto_revert = false
    canary = 0
  }

  migrate {
    max_parallel = 1
    health_check = "checks"
    min_healthy_time = "10s"
    healthy_deadline = "5m"
  }

  group "main" {
    count = 1

    network {
      port "db" {
        to = 6379
      }
    }

    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }

    ephemeral_disk {
      size = 300
    }

    task "migrate" {
      driver = "docker"

      config {
        image = "node:15-alpine"
      }
    }

    task "pg" {
      driver = "docker"

      config {
        image = "node:15-alpine"
      }
    }

    task "nginx" {
      driver = "docker"

      config {
        image = "node:15-alpine"
      }
    }

    task "gateway" {
      driver = "docker"

      config {
        image = "node:15-alpine"
      }
    }

    task "jwt-maker" {
      driver = "docker"

      config {
        image = "node:15-alpine"
      }
    }
  }
}
