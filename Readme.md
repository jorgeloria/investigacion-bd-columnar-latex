Here’s the updated **`README.md`** with the new `-n` flag and parameterized usage:

````markdown
# LaTeX Docker Build Setup

This repository provides a reproducible environment to build LaTeX Apa7 projects
using Docker. It works like a lightweight Overleaf: you write `.tex` files
locally, and Docker compiles them into PDFs.

---

## 🚀 Getting Started

### 1. Build the Docker image
```bash
docker build -t my-latex .
````

> You only need to do this once, unless you change the `Dockerfile`.

### 2. Compile your document

Use the helper script:

```bash
./build.sh
```

This will:

* (Re)build the Docker image (unless you skip with `-n`)
* Clean up old LaTeX auxiliary files (`.aux`, `.log`, `.toc`, etc.)
* Build a fresh PDF from your `.tex` file

---

## ⚙️ Script Options

The `build.sh` script supports flags for flexibility:

```bash
Usage: ./build.sh [options]

Options:
  -i IMAGE   Docker image name (default: my-latex)
  -f FILE    TeX file to compile (default: main.tex)
  -n         Skip rebuilding Docker image
  -h         Show help
```

### Examples

* Default build (rebuild image, compile `main.tex`):

  ```bash
  ./build.sh
  ```

* Compile another file:

  ```bash
  ./build.sh -f report.tex
  ```

* Use a custom Docker image name:

  ```bash
  ./build.sh -i texbuilder
  ```

* Skip rebuilding the image (faster):

  ```bash
  ./build.sh -n
  ```

* Combine options:

  ```bash
  ./build.sh -n -i texbuilder -f thesis.tex
  ```

---

## 🧹 Cleaning manually

If you want to remove auxiliary files without compiling:

```bash
docker run --rm -v "$(pwd)":/workdir my-latex latexmk -C
```

To remove *everything including the PDF*:

```bash
docker run --rm -v "$(pwd)":/workdir my-latex latexmk -CA
```

---

## 📄 Project Structure

```
.
├── Dockerfile       # Defines LaTeX build environment
├── build.sh         # Helper script to clean + compile
├── main.tex         # Your LaTeX source file
└── main.pdf         # Output (generated)
```

---

## ⚡ Notes

* By default, `build.sh` compiles `main.tex`.
* You can override this with `-f filename.tex`.
* All builds are reproducible: anyone with Docker can get the same result.

```

---

👉 Do you also want me to add a **section with common LaTeX packages** (like `biblatex`, `tikz`, etc.) so contributors know what’s already included in the Docker image?
```
