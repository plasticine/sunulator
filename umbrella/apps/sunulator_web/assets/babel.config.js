module.exports = (api) => {
  api.cache.using(() => process.env.NODE_ENV);

  const presets = [
    ['@babel/flow'],
    ['@babel/react'],
    ['@babel/env', { modules: false }]
  ];

  const plugins = [];

  switch (api.env()) {
    case 'development':
      plugins.push('flow-react-proptypes');
      break;

    case 'test':
      plugins.push('flow-react-proptypes');
      break;
  }

  return { presets, plugins };
};
