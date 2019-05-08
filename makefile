default: main
	./Main script

main: Main.hs Parse.hs Transform.hs Line.hs Solids.hs Screen.hs DrawMats.hs \
		Lighting.hs
	ghc -dynamic -O2 Main.hs

clean:
	rm *.hi *.o Main .tempimg.ppm

imgclean:
	rm *.ppm *.png .tempimg.ppm

run:
	./Main script
