import './Components/Sidebar/sidebar.css'
import './Main.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

Main.embed(document.getElementById('yoruichi'));

registerServiceWorker();
