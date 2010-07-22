DATE := `date +%Y%m%d`

all: tic64x-binutils.spec llvm.spec

tic64x-binutils.spec: tic64x-binutils.spec.in
	( cd git ; \
	tmp=`ls binutils*tar.bz2 | head -n 1 | egrep -o -- '-git[^.]+'` ; \
	cd .. ; \
	hash=`echo $${tmp:4}` ; \
	sed -e "s/GIT_HASH/$${hash}/" $< > $@ ; )
	sed -e "s/GIT_DATE/${DATE}/" -i $@

llvm.spec: llvm.spec.in
	( cd git ; \
	tmp=`ls clang*tar.bz2 | head -n 1 | egrep -o -- '-git[^.]+'` ; \
	cd .. ; \
	hash=`echo $${tmp:4}` ; \
	sed -e "s/CLANG_GIT_HASH/$${hash}/" $< > $@ ; )
	sed -e "s/CLANG_GIT_DATE/${DATE}/" -i $@

	( cd git ; \
	tmp=`ls llvm*tar.bz2 | head -n 1 | egrep -o -- '-git[^.]+'` ; \
	cd .. ; \
	hash=`echo $${tmp:4}` ; \
	sed -e "s/GIT_HASH/$${hash}/" -i $@ ; )
	sed -e "s/GIT_DATE/${DATE}/" -i $@

.PHONY: clean-specs

clean-specs:
	-rm -f *.spec

