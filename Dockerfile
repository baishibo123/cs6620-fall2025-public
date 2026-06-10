FROM python:3.11-slim

WORKDIR /app

# 系统依赖（你的 requirements 里有 SDL 相关）
RUN apt-get update && apt-get install -y \
    libsdl1.2-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Build-time labels，供后续 inspect 验证用
ARG VCS_REF
ARG RUN_ID
LABEL build.source="github-actions" \
      build.workflow="Docker Build, Push, and Deploy" \
      build.run_id="${RUN_ID}" \
      org.opencontainers.image.revision="${VCS_REF}"

EXPOSE 3000

CMD ["python", "app.py"]
