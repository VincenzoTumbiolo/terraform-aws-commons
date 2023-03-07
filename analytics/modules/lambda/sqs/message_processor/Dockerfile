FROM node:16-buster

COPY . .
RUN yarn
RUN yarn build

CMD [ "yarn", "locally" ]
