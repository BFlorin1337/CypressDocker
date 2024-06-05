const { defineConfig } = require('cypress');

module.exports = (on, config) => {
  on('before:browser:launch', (browser = {}, launchOptions) => {
    if (browser.name === 'chrome' && browser.isHeadless) {
      launchOptions.args.push('--disable-gpu');
      launchOptions.args.push('--no-sandbox');
      launchOptions.args.push('--disable-dev-shm-usage');
      launchOptions.args.push('--disable-logging');
      launchOptions.args.push('--excludeSwitches', ['enable-logging']);
    }
    return launchOptions;
  });
};
