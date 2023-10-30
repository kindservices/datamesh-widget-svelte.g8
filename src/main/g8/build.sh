#!/usr/bin/env bash
export TAG=\${TAG:-local}
export IMG=\${IMG:-$org$/$image$:\$TAG}
export PORT=\${PORT:-3000}


build() {
    echo "Building \$IMG..."
    docker build --tag \$IMG .
    echo "Built \$IMG. To run:"
    echo ""
    echo "docker run --rm -name $widget$ -it -p \$PORT:80 \$IMG"
    echo "    docker run --rm --name $widget$ -d -it -p \$PORT:80 \$IMG"
    echo ""
    echo "And open http://localhost:\$PORT/bundle.js or http://localhost:\$PORT/bundle.css"
    echo ""
    echo "Once running, to manually test, open ./test/local-test.html or ./test/dynamic-test.html"
    echo ""
}

dev() {
    which pnpm || (echo "pnpm not installed. Try 'brew install pnpm'?" && exit 1)
    pnpm install
    pnpm dev
}

clean() {
    pnpm store prune
}

run() {
    echo "docker run -it --rm -p \$PORT:80 -d \$IMG"
    id=`docker run -it --rm -p \$PORT:80 -d \$IMG`
    cat > kill.sh <<EOL
docker kill \$id
# clean up after ourselves
rm kill.sh
EOL
    chmod +x kill.sh

    echo "Running on port \$PORT --- stop server using ./kill.sh"
}

installArgo() {
    APP=\${APP:-$name;format="camel"$}
    BRANCH=\${BRANCH:-`git rev-parse --abbrev-ref HEAD`}

    echo "creating \$APP"
    
    kubectl create namespace $k8namespace$ > /dev/null

    # beast mode :-)
    argocd app create \$APP \
    --repo https://github.com/$org$/$githubrepo$.git \
    --path k8s \
    --dest-server https://kubernetes.default.svc \
    --dest-namespace $k8namespace$ \
    --sync-policy automated \
    --auto-prune \
    --self-heal \
    --revision \$BRANCH

}