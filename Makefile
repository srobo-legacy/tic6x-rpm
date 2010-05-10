DATE := `date +%Y%m%d`

tic64x-binutils.spec: tic64x-binutils.spec.in
	( cd git ; \
	tmp=`ls binutils*tar.bz2 | head -n 1 | egrep -o -- '-git[^.]+'` ; \
	cd .. ; \
	hash=`echo $${tmp:4}` ; \
	sed -e "s/GIT_HASH/$${hash}/" $< > $@ ; )
	sed -e "s/GIT_DATE/${DATE}/" -i $@

.PHONY: clean-specs

clean-specs:
	-rm -f *.spec

