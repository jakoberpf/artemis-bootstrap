banner:
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

kubespray: banner kubespray.deploy kubespray.post

kubespray.clone: banner
	@git clone --branch v2.21.0 https://github.com/kubernetes-sigs/kubespray.git .kubespray

kubespray.deploy: banner
	@echo "[kubespray] Bootstrap cluster with kubespray"
	@./bin/kubespray-deploy.sh

kubespray.post: banner
	@echo "[kubespray] Postprocessing kubespray bootstrapping"
	@./bin/kubespray-post.sh

ansible: banner
	@echo "[ansible] Configuring bootstraped infrastructure"
	@./bin/ansible-playbook.sh

deploy: ansible kubespray
	@echo "[kubespray] Deploy RaspberryPi Kubernetes Cluster"
