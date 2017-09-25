import './Components/Sidebar/sidebar.css'
import './Components/Calendar/calendar.css'
import './main.css'
import { Main } from './Main.elm'
import registerServiceWorker from './registerServiceWorker'

Main.embed(document.getElementById('yoruichi'));

registerServiceWorker();
