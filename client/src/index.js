import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';

const savedTheme = localStorage.getItem('foodhub-theme');
const systemDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
const useDarkTheme = savedTheme === 'dark' || (!savedTheme && systemDark);

document.documentElement.classList.toggle('dark', useDarkTheme);
document.documentElement.style.colorScheme = useDarkTheme ? 'dark' : 'light';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
