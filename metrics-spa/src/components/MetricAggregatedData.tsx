import { useState, useEffect } from 'react';
import { MetricAggregatedData, showMetricAggregatedData } from '../api';
import { useParams } from 'react-router-dom';
import { Bar } from 'react-chartjs-2';

const MetricAggregatedDataComponent = () => {
  const [duration, setDuration] = useState('day');
  const [chartData, setChartData] = useState(null);
  const { applicationId, metricName } = useParams<{ applicationId: string, metricName: string }>()

  useEffect(() => {
    showMetricAggregatedData(applicationId, metricName, duration)
      .then(data => {
        // Process data and update chartData state
        const parsedData = parseDataForChart(data);
        console.log(parsedData)
        setChartData(parsedData);
      })
      .catch(error => {
        console.error('Error fetching data:', error);
      });
  }, [duration]);

  const parseDataForChart = (data: MetricAggregatedData[]) => {
    const labels = data.map(entry => entry.date);
    const counts = data.map(entry => entry.count);
    const p99 = data.map(entry => entry.p99);
    const p95 = data.map(entry => entry.p95);
    const p50 = data.map(entry => entry.p50);
    const avg = data.map(entry => entry.avg);

    return {
      labels: labels,
      datasets: [
        {
          label: 'count',
          borderWidth: 1,
          data: counts,
        },
        {
          label: 'p99',
          borderWidth: 1,
          data: p99,
        },
        {
          label: 'p95',
          borderWidth: 1,
          data: p95,
        },
        {
          label: 'p50',
          borderWidth: 1,
          data: p50,
        },
        {
          label: 'AVG',
          borderWidth: 1,
          data: avg,
        },
      ],
    };
  };

  const handleDurationChange = (newDuration: string) => {
    setDuration(newDuration);
  };

  return (
    <div>
      <select value={duration} onChange={(e) => handleDurationChange(e.target.value)}>
        <option value="hour">Hour</option>
        <option value="day">Day</option>
        <option value="week">Week</option>
        <option value="month">Month</option>
      </select>

      {chartData && <Bar data={chartData} />}
    </div>
  );
}

export default MetricAggregatedDataComponent;
