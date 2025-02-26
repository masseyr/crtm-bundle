#simple script to kickstart pycrtm
#update python library
#python -m pip install h5py
mkdir crtm_v2.4.0
cd crtm_v2.4.0
echo "[kickstart] making crtm in crtm-bundle/crtm_v2.4.0:"
ecbuild ../
echo "[kickstart] compiling crtm:"
make -j8
echo "[kickstart] linking to modules:"
ln -fs `find ./ -name "crtm_module.mod" | sed 's/crtm_module.mod//'` ./include
cd ..

cd crtm
echo "[kickstart] getting remote binary data."
sh Get_CRTM_Binary_Files.sh
cd ..

echo "[kickstart] installing pycrtm"
#rm -rf pycrtm
#git clone https://github.com/masseyr/pycrtm.git
cd pycrtm
ls -la
#python3 setup.py install
./setup_pycrtm.py  --install $PWD/../ --repos $PWD/../crtm/ --jproc 1 --coef $PWD/../ --ncpath /usr/local/ --h5path /usr/local/ --arch gfortran --inplace
ln -fs $PWD/../crtm_coef_pycrtm $PWD
ln -fs `find ./ -maxdepth 1 -name "pycrtm.cpython*.so"` ./pycrtm.so
ln -fs ../crtm_v2.4.0/lib/libcrtm.so .
echo "[kickstart] running a testcase."
./testCases/test_cris.py
echo "[kickstart] Read the README.md file for more information (note *_threads.py files currently not functional)."
