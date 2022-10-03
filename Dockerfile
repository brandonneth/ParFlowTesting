FROM chapel/chapel

RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y mpich
RUN apt-get install -y gfortran
RUN apt-get install -y tcl8.6-dev
RUN apt-get install -y tclsh
RUN apt-get install -y bash 
RUN apt-get install -y vim

RUN git clone https://github.com/brandonneth/parflow.git
RUN git clone https://github.com/hypre-space/hypre.git
RUN wget https://wci.llnl.gov/sites/wci/files/2021-09/silo-4.11-bsd-smalltest.tgz


#Get silo configured and installed
RUN tar zxvf silo-4.11-bsd-smalltest.tgz
RUN cd silo-4.11-bsd && ./configure && make -j2 && make install


#Get hyper configured and installed
RUN cd hypre/src && ./configure
RUN cd hypre/src && make -j2
RUN cd hypre/src && make install


ENV PARFLOW_DIR="/parflow"
ENV SILO_DIR="/silo-4.11-bsd"
ENV HYPRE_DIR="/hypre/src/hypre"
ENV CPLUS_INCLUDE_PATH="/usr/include/aarch64-linux-gnu/mpich"
ENV LD_LIBRARY_PATH=/parflow/pfsimulator/chapel/lib
ENV CHPL_LIB_PIC=pic
ENV CXX=g++
ENV CC=gcc

RUN cd $CHPL_HOME && make -j6

RUN cd parflow && git checkout chapel
RUN cd parflow && mkdir build
RUN git clone https://github.com/brandonneth/ParFlowTesting.git
CMD ["bash", "ParFlowTesting/entrypoint.sh"]