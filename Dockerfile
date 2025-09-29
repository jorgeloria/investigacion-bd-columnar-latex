# chatgpt generated
#build it & run it:
    # docker build -t my-latex-apa7 .
    # chmod +x ./build.sh
    # ./build.sh

# Use official TeX Live image (full installation)
FROM texlive/texlive:latest

# Install latexmk and other useful tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        make \
        latexmk \
        ghostscript \
        python3 \
        python3-pip \
        git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workdir

# Default command: run latexmk on main.tex
CMD ["latexmk", "-pdf", "-interaction=nonstopmode", "main.tex"]















#build it & run it:
    # docker build -t my-latex-apa7 .
    # docker run --rm -v "$(pwd)":/data my-latex-apa7 pdflatex main.tex
# # Use the correct, full TeX Live installation from the official path
# FROM texlive/texlive:2024

# # Update tlmgr to ensure it can access the latest repository
# # This is a best practice, but may not be strictly necessary
# # with a recent image like 2024.
# RUN tlmgr update --self

# # Install the apa7 package and its dependencies.
# # The `texlive/texlive:2024` image is already a "full" scheme
# # and should include most packages, but this is a good habit.
# RUN tlmgr install apa7

# # Set the working directory for compilation
# WORKDIR /data

