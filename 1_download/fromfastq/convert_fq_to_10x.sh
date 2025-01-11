#!/bin/bash

# ================================
# 変数の定義
# ================================

# 入力FASTQファイルのディレクトリ
FASTQ_DIR="/path/to/fastq"

# 参照ゲノムディレクトリ（Cell Ranger用に準備された参照）
REFERENCE_DIR="/path/to/reference"

# 出力ディレクトリ
OUTPUT_DIR="/path/to/output"

# サンプルID
SAMPLE_ID="sample_name"

# 使用するCPUコア数
LOCAL_CORES=8

# 使用するメモリ量（GB）
LOCAL_MEM=64

# ================================
# 前処理
# ================================

# 出力ディレクトリが存在しない場合は作成
mkdir -p "${OUTPUT_DIR}"

# ================================
# Cell Rangerの実行
# ================================

cellranger count \
  --id="${SAMPLE_ID}" \
  --transcriptome="${REFERENCE_DIR}" \
  --fastqs="${FASTQ_DIR}" \
  --sample="${SAMPLE_ID}" \
  --output-dir="${OUTPUT_DIR}" \
  --localcores="${LOCAL_CORES}" \
  --localmem="${LOCAL_MEM}"

# ================================
# 結果の確認
# ================================

MOLECULE_INFO_H5="${OUTPUT_DIR}/${SAMPLE_ID}/outs/molecule_info.h5"

if [ -f "${MOLECULE_INFO_H5}" ]; then
  echo "molecule_info.h5 が正常に生成されました: ${MOLECULE_INFO_H5}"
else
  echo "エラー: molecule_info.h5 の生成に失敗しました。"
  exit 1
fi
