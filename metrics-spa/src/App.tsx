import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import './App.css';
import ListApplications from './components/ListApplications';
import ListApplicationMetrics from './components/ListApplicationMetrics';
import MetricAggregatedDataComponent from './components/MetricAggregatedData';
import { Chart as ChartJS, LineController, BarElement, BarController, CategoryScale, LinearScale, Colors, Tooltip, Legend, Title} from 'chart.js';

ChartJS.register(LineController, BarElement, BarController, CategoryScale, LinearScale, Colors, Tooltip, Legend, Title);

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<ListApplications/>} />
        <Route path="/applications/:id" element={<ListApplicationMetrics/>} />
        <Route path="/applications/:applicationId/metrics/:metricName" element={<MetricAggregatedDataComponent/>} />
      </Routes>
    </Router>
  );
}

export default App;
