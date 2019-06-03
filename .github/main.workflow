workflow "Deploy" {
  on = "push"
  resolves = ["Deploy to GitHub Pages"]
}

action "Deploy to GitHub Pages" {
  uses = "JamesIves/github-pages-deploy-action@1.1.2"
  env = {
    BUILD_SCRIPT = "npm install && npm run build"
    FOLDER = "dist"
    BRANCH = "gh-pages"
  }
  secrets = ["ACCESS_TOKEN"]
}
