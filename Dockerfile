# ============================
# 1. Builder Stage
# ============================
FROM python:3.10-slim AS builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --prefix=/install -r requirements.txt

# ============================
# 2. Final Image
# ============================
FROM python:3.10-slim

RUN addgroup --system appgroup && adduser --system appuser --ingroup appgroup

WORKDIR /app

COPY --from=builder /install /usr/local
COPY . .

USER appuser

CMD ["python", "run.py"]
 


