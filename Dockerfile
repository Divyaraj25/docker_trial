# Start from the official Node.js 18.19 image
FROM node:18.19
 
# Set the working directory in the container
ARG WORK_DIR=/frontend
# Update the PATH environment variable to include the node_modules/.bin directory
ENV PATH=${WORK_DIR}/node_modules/.bin:$PATH
 
# Create the working directory if it doesn't exist
RUN mkdir ${WORK_DIR}
# Switch to the working directory
WORKDIR ${WORK_DIR}
 
# Copy the package.json and package-lock.json files to the working directory
COPY package.json ${WORK_DIR}
COPY package-lock.json ${WORK_DIR}

# Install the dependencies listed in package.json
RUN npm install --force

# Copy the rest of the code to the working directory
COPY . ${WORK_DIR}
# Run the build command to build the Angular app
RUN npm run build
 
# Expose port 4200 for the server
EXPOSE 4200
 
# Set the default command to run the server
CMD ["node","./server.js"]