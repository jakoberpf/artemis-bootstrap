# https://makefiletutorial.com/
all: deploy

banner: # Typo: Allogator2 from https://manytools.org/hacker-tools/ascii-banner/
	@echo "############################################################################################"
	@echo "##                                                                                        ##"
	@echo "##        :::     ::::::::: ::::::::::: :::::::::: ::::    ::::  ::::::::::: ::::::::     ##"
	@echo "##      :+: :+:   :+:    :+:    :+:     :+:        +:+:+: :+:+:+     :+:    :+:    :+:    ##"
	@echo "##     +:+   +:+  +:+    +:+    +:+     +:+        +:+ +:+:+ +:+     +:+    +:+           ##"
	@echo "##    +#++:++#++: +#++:++#:     +#+     +#++:++#   +#+  +:+  +#+     +#+    +#++:++#++    ##"
	@echo "##    +#+     +#+ +#+    +#+    +#+     +#+        +#+       +#+     +#+           +#+    ##"
	@echo "##    #+#     #+# #+#    #+#    #+#     #+#        #+#       #+#     #+#    #+#    #+#    ##"
	@echo "##    ###     ### ###    ###    ###     ########## ###       ### ########### ########     ##"
	@echo "##                                                                                        ##"
	@echo "############################################################################################"
	@echo "                                                                                            "

vault: banner
	@echo "[vault] Getting configuration and secrets from Vault"
	@./bin/vault.sh

kubespray: banner vault
	@echo "[kubespray] Configuring cluster infrastructure with kubespray"
	@./bin/kubespray.sh

deploy: banner kubespray
	@echo "[deploy] Finished bootstrapping cluster"
