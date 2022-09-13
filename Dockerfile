FROM chapel/chapel

RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y mpich
RUN apt-get install -y gfortran
RUN apt-get install -y tcl8.6-dev

RUN git clone https://github.com/brandon-neth/parflow.git
RUN git clone https://github.com/hypre-space/hypre.git
RUN wget https://wci.llnl.gov/sites/wci/files/2021-09/silo-4.11-bsd-smalltest.tgz


#Get silo configured and installed
RUN tar zxvf silo-4.11-bsd-smalltest.tgz
RUN cd silo-4.11-bsd && ./configure && make -j2 && make install


#Get hyper configured and installed
RUN cd hypre/src && ./configure
RUN cd hypre/src && make -j2
RUN cd hypre/src && make install



RUN cd parflow && git checkout chapel
RUN cd parflow && mkdir bu ild

RUN git clone 
CMD ["ParFlowTesting/entrypoint.sh"]