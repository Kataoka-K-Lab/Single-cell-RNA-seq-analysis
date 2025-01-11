# Cell Ranger Installation and Reference Genome Setup

## 1. Prerequisites

Before installing Cell Ranger, ensure the following requirements are met:

### 1.1 System Requirements
- **Operating System**: Linux (64-bit), such as CentOS 7, Ubuntu 18.04 or later.
- **CPU**: x86_64-compatible processor.
- **Memory**: At least 16 GB of RAM (64 GB or more is recommended for larger datasets).
- **Disk Space**: At least 100 GB of free disk space for the installation and temporary files.

### 1.2 Software Requirements
- **curl**: Used to download the software.
- **bash**: To execute scripts.
- **Python**: A version compatible with Cell Ranger (Python 2.7 or 3.x is fine for most systems).

---

## 2. Installing Cell Ranger

### 2.1 Download the Software
1. Visit the [official Cell Ranger download page](https://support.10xgenomics.com/single-cell-gene-expression/software/downloads/latest).
2. Copy the download link for the desired version.
3. Use `curl` to download the tarball:

   ```bash
   curl -O https://cf.10xgenomics.com/releases/cell-exp/cellranger-7.0.1.tar.gz
   ```

### 2.2 Extract the Software
Extract the downloaded tarball and move it to a suitable location:

```bash
tar -xvzf cellranger-7.0.1.tar.gz
mv cellranger-7.0.1 /opt/cellranger
```

### 2.3 Add Cell Ranger to PATH
Add the Cell Ranger binary to your system PATH for easier access:

```bash
echo 'export PATH=/opt/cellranger:$PATH' >> ~/.bashrc
source ~/.bashrc
```

### 2.4 Verify Installation
Test if Cell Ranger was installed successfully:

```bash
cellranger --version
```

This should output the version of Cell Ranger installed, e.g., `cellranger 7.0.1`.

---

## 3. Preparing the Reference Genome

Cell Ranger requires a compatible reference genome in its own format. This section describes how to prepare the reference genome using `cellranger mkref`.

### 3.1 Obtain Genome Files
You will need the following files for your reference genome:

1. **FASTA file**: Contains the genomic sequences.
2. **GTF file**: Annotation file with gene features.

These files can be downloaded from Ensembl or UCSC Genome Browser. For example, to download the mouse genome:

```bash
curl -O ftp://ftp.ensembl.org/pub/release-109/fasta/mus_musculus/dna/Mus_musculus.GRCm39.dna.primary_assembly.fa.gz
curl -O ftp://ftp.ensembl.org/pub/release-109/gtf/mus_musculus/Mus_musculus.GRCm39.109.gtf.gz
```

### 3.2 Prepare Files
1. Unzip the downloaded files:

   ```bash
   gunzip Mus_musculus.GRCm39.dna.primary_assembly.fa.gz
   gunzip Mus_musculus.GRCm39.109.gtf.gz
   ```

2. Ensure the filenames are clear and consistent:

   - FASTA: `Mus_musculus.GRCm39.dna.primary_assembly.fa`
   - GTF: `Mus_musculus.GRCm39.109.gtf`

### 3.3 Create the Reference
Use `cellranger mkref` to build the reference genome:

```bash
cellranger mkref \
  --genome=mm10 \
  --fasta=Mus_musculus.GRCm39.dna.primary_assembly.fa \
  --genes=Mus_musculus.GRCm39.109.gtf
```

### 3.4 Reference Directory Structure
After running the above command, a new directory named `mm10` will be created. The directory contains the following:

- `fasta/`
- `genes/`
- `star/`

These files are used internally by Cell Ranger during analysis.

---

## 4. Testing the Installation and Reference Genome

### 4.1 Sample Data
You can download sample data from the [10x Genomics support site](https://support.10xgenomics.com/).

```bash
curl -O https://cf.10xgenomics.com/samples/cell-exp/7.0.1/3k_hgmm_v3/3k_hgmm_v3_fastqs.tar.gz
```

Extract the sample data:

```bash
tar -xvzf 3k_hgmm_v3_fastqs.tar.gz
```

### 4.2 Run Cell Ranger
Test your installation by running `cellranger count` on the sample data:

```bash
cellranger count \
  --id=test_sample \
  --transcriptome=mm10 \
  --fastqs=3k_hgmm_v3_fastqs \
  --sample=sample_name \
  --localcores=8 \
  --localmem=64
```

### 4.3 Verify Results
Upon completion, check the output directory (`test_sample/outs`) for results, including the `molecule_info.h5` file.

---

## 5. Troubleshooting

### 5.1 Common Errors
- **"Invalid FASTA or GTF file format"**:
  Ensure the FASTA and GTF files are correctly formatted and compatible with Cell Ranger.

- **"Insufficient Memory"**:
  Increase the `--localmem` parameter or use a machine with more RAM.

- **"Command Not Found"**:
  Ensure Cell Ranger is added to your PATH and the environment variables are correctly set.

---

## 6. Additional Resources
- [10x Genomics Documentation](https://support.10xgenomics.com/)
- [Ensembl Genome Browser](https://www.ensembl.org/)
- [UCSC Genome Browser](https://genome.ucsc.edu/)

For further assistance, consult the Cell Ranger user guide or contact 10x Genomics support.
