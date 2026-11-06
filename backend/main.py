from fastapi import FastAPI
import pymysql
import os

app = FastAPI()

# 도커 컴포즈 설계도에 적힌 이름들
DB_HOST = os.environ.get('DB_HOST', 'my-db')
# 비밀번호는 기본값 없이 환경변수(.env -> docker-compose)로만 받는다
DB_PASS = os.environ['DB_PASSWORD']

@app.get("/api/status")
def get_murim_status():
    try:
        # 1. DB에 접속
        conn = pymysql.connect(
            host=DB_HOST, user='root', password=DB_PASS,
            db='murim_db', charset='utf8mb4',
            cursorclass=pymysql.cursors.DictCursor
        )
        with conn.cursor() as cursor:
            # 2. 가장 최근 무인 정보 1개 가져오기
            cursor.execute("SELECT name, school, skill FROM characters ORDER BY id DESC LIMIT 1")
            result = cursor.fetchone()
        conn.close()
        return result
    except Exception as e:
        return {"name": "연결 실패", "school": "오류", "skill": str(e)}
