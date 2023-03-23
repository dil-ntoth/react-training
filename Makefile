# Requirements: 
#	* `reveal-md` must be globally installed for presnetation
#	* `docker` must be installed and configured for interactive presenation
# 
# Usage:
# 	`make present presentation=0-philosophy/PRESENTATION.md`
#	`make interactive presentation=0-philosophy/PRESENTATION.ipynb`	
#
present:
	reveal-md $(presentation) --theme theme/diligent.css
develop:
	reveal-md $(presentation) -w --theme theme/diligent.css

pdf:
	reveal-md $(presentation) --theme theme/diligent.css --print slides.pdf
