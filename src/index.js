import './Components/Sidebar/sidebar.css'
import './Components/Calendar/calendar.css'
import './Components/ContextMenu/contextMenu.css'
import './main.css'
import { Main } from './Main.elm'
import registerServiceWorker from './registerServiceWorker'

console.log(process.env);
if (process.env.NODE_ENV !== "production") {

  const getWeekExtreme = check => date => {
    const d = new Date(date)
    const day = d.getDay()
    const diff = d.getDate() - day + check(day)
    d.setDate(diff)
    return d
  }

  const weekBeginning = getWeekExtreme((d) => d === 0 ? -6:1)
  const weekEnding = getWeekExtreme((d) => d === 0 ? 0:7)

  const padNumber = (n, width, z = 0) => {
     n += '';
     return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
  }
  const formatDateForInput = d => {
    if (!d) return '';
    const date = new Date(d);
    return `${date.getFullYear()}-${padNumber(date.getMonth()+1, 2)}-${padNumber(date.getDate(), 2)}`;
  }

  const setTimeForDate = (h, m, s) => date => {
    const d = new Date(date);
    return new Date(d.getFullYear(), d.getMonth(), d.getDate(), h, m, s);
  }
  const startOfDay = setTimeForDate(0, 0, 0)
  const endOfDay = setTimeForDate(23, 59, 59)

  const app = Main.embed(document.getElementById('yoruichi'));

  const tasks = [{ id: 1, description: "Buy Milk", isComplete: false, repeatFrequency: 2, repeatDay: "2017-09-25" }
                ,{ id: 2, description: "Read Paper", isComplete: false, repeatFrequency: 1, repeatDay: "2017-09-26" }
                ,{ id: 3, description: "Cut the grass", isComplete: false, repeatFrequency: 3, repeatDay: "2017-09-26" }
                ,{ id: 4, description: "Put the bins out", isComplete: false, repeatFrequency: 2, repeatDay: "2017-09-27" }
                ,{ id: 5, description: "Write Ports", isComplete: false, repeatFrequency: 0, repeatDay: "2017-09-29" }
                ,{ id: 6, description: "Enjoy holiday", isComplete: false, repeatFrequency: 0, repeatDay: "2017-10-02" }
                ,{ id: 7, description: "Be scared for tomorrow", isComplete: false, repeatFrequency: 0, repeatDay: "2017-10-08" }
                ,{ id: 8, description: "Cry", isComplete: false, repeatFrequency: 0, repeatDay: "2017-10-09" }
                ]

  app.ports.fetch.subscribe(function ({ timePeriod, targetDate }) {
    const date = new Date(targetDate)
    const handleFilter = d => d <= range[1] && d >= range[0]
    let range

    if (timePeriod === "DAY") {
      range = [formatDateForInput(startOfDay(targetDate)), formatDateForInput(endOfDay(targetDate))]
    } else if (timePeriod === "WEEK") {
       range = [formatDateForInput(startOfDay(weekBeginning(targetDate))), formatDateForInput(endOfDay(weekEnding(targetDate)))]
    }

    var done = false
    const filtered = tasks.filter(x => handleFilter(x.repeatDay))
    Promise.resolve(filtered).then(result => {
      app.ports.tasks.send(result)
    })
  })

  app.ports.update.subscribe(function(task) {
    console.log("task >> ", task);
    console.log(`${task.id === 0 ? "CREATE" : "UPDATE"}`)
  })

  app.ports.delete.subscribe(function(taskId) {
    console.log("delete task with id >> ", taskId);
  })

}

registerServiceWorker();

export default Main
