# ------------------------------------------------------------------
# 입력 변수
#  - 실제 값은 terraform.tfvars (gitignore 대상)에 두고,
#    형식은 terraform.tfvars.example 을 참고하세요.
#  - 비밀번호 변수는 기본값 없이 sensitive 로 선언합니다.
# ------------------------------------------------------------------

variable "my_ip_cidr" {
  description = "DB·모니터링 포트(3306/3000/9090/8081)를 허용할 관리자 공인 IP (예: 203.0.113.10/32)"
  type        = string

  validation {
    condition     = can(cidrhost(var.my_ip_cidr, 0))
    error_message = "my_ip_cidr 는 CIDR 형식이어야 합니다 (예: 203.0.113.10/32)."
  }
}

variable "ssh_allowed_cidr" {
  description = "SSH(22) 허용 대역. GitHub Actions 러너 IP가 고정이 아니어서 기본값은 전체 개방(키 인증만 허용)입니다."
  type        = string
  default     = "0.0.0.0/0"

  validation {
    condition     = can(cidrhost(var.ssh_allowed_cidr, 0))
    error_message = "ssh_allowed_cidr 는 CIDR 형식이어야 합니다."
  }
}

variable "mysql_root_password" {
  description = "MariaDB root 비밀번호 (.env 의 MYSQL_ROOT_PASSWORD)"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "백엔드가 DB에 접속할 때 쓰는 비밀번호 (.env 의 DB_PASSWORD)"
  type        = string
  sensitive   = true
}

variable "grafana_admin_user" {
  description = "Grafana 관리자 계정명 (.env 의 GRAFANA_ADMIN_USER)"
  type        = string
  default     = "admin"
}

variable "grafana_admin_password" {
  description = "Grafana 관리자 비밀번호 (.env 의 GRAFANA_ADMIN_PASSWORD)"
  type        = string
  sensitive   = true
}
