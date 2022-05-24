#!/bin/bash

cat > customize.sh << EOF
#!/bin/bash

##README file changes
sed -i '' 's/elementor/AnyCompany/' README.md
sed -i '' 's/Elementor/AnyCompany/' README.md

##Footer file changes
sed -i '' 's/Elementor/AnyCompany/' components/Footer.js

##Header file changes
sed -i '' 's/Elementor For/AnyCompany Solutions/' components/Header/Header.js

##icon file changes
sed -i '' 's/Elementor/AnyCompany/' components/Icon.js

##Expert file changes
sed -i '' 's/Elementor/AnyCompany/' components/homePage/ExpertSection.js

##Meet file changes
sed -i '' 's/Elementor/AnyCompany/' components/homePage/MeetSection.js

##Testimony file changes
sed -i '' 's/Elementor/AnyCompany/' components/homePage/TestimonySection.js

#Video file changes
sed -i '' '7s/<div/{\/*<div/' components/homePage/VideoSection.js
sed -i '' '18s/div>/{div> *\/}/' components/homePage/VideoSection.js

##data file changes
sed -i '' 's/Elementor/AnyCompany/' data/data.js

#index file changes
sed -i '' '4s/import/\/\/import/' pages/index.js
sed -i '' 's/Elementor/AnyCompany/' pages/index.js
sed -i '' '42s/<div/{\/*<div/' pages/index.js
sed -i '' '44s/div>/{div> *\/}/' pages/index.js

##icon1 file changes
sed -i '' 's/Elementor/AnyCompany/' public/Icon1.png
EOF

cat > Dockerfile << EOF
FROM node:alpine

RUN mkdir -p /usr/src/app
ENV PORT 3000
ENV NODE_OPTIONS --openssl-legacy-provider

WORKDIR /usr/src/app

COPY package-lock.json package.json /usr/src/app

# Production use node instead of root
# USER node

RUN npm install
COPY . /usr/src/app
RUN npm run build

EXPOSE 3000
CMD [ "npm", "start" ]
EOF

cat > .dockerignore << EOF
node_modules
npm-debug.log

# next.js
/.next/
/out/

# production
/build

# misc
.DS_Store
*.pem

# debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*

/screenshots
EOF

cat > build.sh << \EOF
tag=`date -u '+%Y-%m-%dT%H%M%S'`
DOCKER_BUILDKIT=1 docker build -t summit-demo:$tag .
docker tag summit-demo:$tag summit-demo:latest 
docker tag summit-demo:$tag $AWS_ACCOUNT.dkr.ecr.$REGION.amazonaws.com/summit-demo:$tag 
docker tag summit-demo:$tag $AWS_ACCOUNT.dkr.ecr.$REGION.amazonaws.com/summit-demo:latest 
docker push $AWS_ACCOUNT.dkr.$REGION.amazonaws.com/summit-demo:$tag
docker push $AWS_ACCOUNT.dkr.ecr.$REGION.amazonaws.com/summit-demo:latest
EOF
