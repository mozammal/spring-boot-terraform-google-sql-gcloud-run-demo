resource google_project_service "google_run_service" {
  service = "run.googleapis.com"
}

resource google_sql_database_instance "cloudrun-sql1" {
  name             = "cloudrun-sql1"
  database_version = "MYSQL_5_7"
  region           = "us-central1"
  settings {
    tier = "db-f1-micro"
  }
  deletion_protection = "false"
}

resource google_sql_database "sql_database" {
  instance = google_sql_database_instance.cloudrun-sql1.name
  name     = "sql_database"
}

resource random_password "user_password" {
  length = 16
}

resource google_sql_user "sql_user" {
  instance = google_sql_database_instance.cloudrun-sql1.name
  name     = "sql_user"
  password = random_password.user_password.result
}

resource "google_cloud_run_service" "spring_boot_terraform_sql_cloud_run_service" {
  name     = "spring-boot-sql-service"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/ultimate-hydra-288114/spring-boot-terraform-google-sql-gcloud-run"
        env {
          name  = "spring.cloud.gcp.sql.instance-connection-name"
          value = google_sql_database_instance.cloudrun-sql1.connection_name
        }

        env {
          name  = "spring.cloud.gcp.sql.database-name"
          value = google_sql_database.sql_database.name
        }

        env {
          name  = "spring.datasource.username"
          value = google_sql_user.sql_user.name
        }

        env {
          name  = "spring.datasource.password"
          value = google_sql_user.sql_user.password
        }
      }
    }
  }
  depends_on = [
  google_project_service.google_run_service]

  metadata {
    annotations = {
      "autoscaling.knative.dev/maxScale"      = "1000"
      "run.googleapis.com/cloudsql-instances" = "${var.project_id}:us-central1:${google_sql_database_instance.cloudrun-sql1.name}"
      "run.googleapis.com/client-name"        = "terraform"
    }
  }
}

data google_iam_policy "iam_policy_all_users" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource google_cloud_run_service_iam_policy "hello_all_users" {
  service     = google_cloud_run_service.spring_boot_terraform_sql_cloud_run_service.name
  location    = google_cloud_run_service.spring_boot_terraform_sql_cloud_run_service.location
  policy_data = data.google_iam_policy.iam_policy_all_users.policy_data
}

output "url" {
  value = "${google_cloud_run_service.spring_boot_terraform_sql_cloud_run_service.status[0].url}"
}