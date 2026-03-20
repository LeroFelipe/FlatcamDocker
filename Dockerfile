FROM debian:bookworm-slim

# Evita que o apt fique fazendo perguntas durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# Adicionamos libglu1-mesa para resolver o erro de gluNewTess
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    python3-venv \
    python3-pyqt5 \
    python3-pyqt5.qtopengl \
    python3-numpy \
    python3-scipy \
    python3-matplotlib \
    python3-shapely \
    python3-rtree \
    python3-simplejson \
    libqt5gui5 \
    libqt5widgets5 \
    libqt5core5a \
    libqt5svg5-dev \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libcairo2-dev \
    pkg-config \
    libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Baixamos o FlatCAM Beta
RUN git clone -b Beta https://bitbucket.org/jpcgt/flatcam.git .

# Criamos o ambiente virtual
RUN python3 -m venv /opt/venv --system-site-packages
ENV PATH="/opt/venv/bin:$PATH"

# Instalamos o pacotão de dependências (com a trava do NumPy 1.x)
RUN pip install --no-cache-dir \
    "numpy<2" \
    vispy==0.7 \
    svg.path \
    ezdxf \
    reportlab \
    lxml \
    qrcode \
    svglib \
    fonttools \
    rasterio \
    PyOpenGL \
    networkx \
    ortools \
    dill \
    requests \
    pyserial

CMD ["python3", "FlatCAM.py"]