data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2004-lts"
  project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "instance" {
  name         = "nextcloud-instance"
  machine_type = "e2-small"
  zone         = "europe-west3-a"
  tags = ["nextcloud"]

  scheduling {
    preemptible = true
    automatic_restart = false
  }
  
  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size = 10
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = file("startup.sh")

}