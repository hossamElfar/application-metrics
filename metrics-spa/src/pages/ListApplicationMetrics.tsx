import React, { useState, useEffect } from 'react'
import { createApplicationMetricDataPoint, listApplicatioMetrics, type Metric } from '../api'
import { Link, useParams, useLocation } from 'react-router-dom'

const ListApplicationMetrics: React.FC = () => {
  const { id } = useParams<{ id: string }>()
  const { state } = useLocation()
  const [data, setData] = useState<Metric[] | null>(null)
  const [isModalOpen, setIsModalOpen] = useState(false)
  const [error, setError] = useState(null)
  const [successMessage, setSuccessMessage] = useState(null)
  const [formData, setFormData] = useState({
    metricName: '',
    timestamp: '',
    value: ''
  })

  const openModal = () => {
    setIsModalOpen(true)
  }

  const closeModal = () => {
    setIsModalOpen(false)
    setError(null)
    setSuccessMessage(null)
  }

  const handleChange = (e: any) => {
    const { name, value } = e.target
    setFormData({ ...formData, [name]: value })
  }

  const handleSubmit = async (e: any) => {
    e.preventDefault()
    try {
      await createApplicationMetricDataPoint(id, formData)
      setIsModalOpen(false)
      setFormData({
        metricName: '',
        timestamp: '',
        value: ''
      })
      setSuccessMessage('Metric data point created successfully.')
      setTimeout(async () => {
        const result = await listApplicatioMetrics(id)
        setData(result)
      }, 3000)
      setTimeout(() => {
        setSuccessMessage(null)
      }, 10000)
    } catch (error: any) {
      console.error('Error creating metric:', error)
      setError(error.response?.data?.message)
    }
  }

  useEffect(() => {
    const fetchDataFromApi = async () => {
      try {
        const result = await listApplicatioMetrics(id)
        setData(result)
      } catch (error) {
        console.error(error)
      }
    }

    fetchDataFromApi()
  }, [])

  return (
    <div className="container mx-auto mt-8">
      {/* Button to open modal */}
      <button onClick={openModal} className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
        Create Metric Data Point
      </button>

      {successMessage && (
        <div className="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
          {successMessage}
        </div>
      )}

      {/* Modal */}
      {isModalOpen && (
        <div className="fixed z-10 inset-0 overflow-y-auto">
          <div className="flex items-center justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">

            {/* Background overlay */}
            <div className="fixed inset-0 transition-opacity" aria-hidden="true">
              <div className="absolute inset-0 bg-gray-500 opacity-75"></div>
            </div>

            {/* Modal panel */}
            <span className="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>
            <div className="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
              <form onSubmit={handleSubmit} className="px-4 pt-5 pb-4 sm:p-6 sm:pb-4">

                {/* Error message */}
                {error && (
                  <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                    {error}
                  </div>
                )}

                {/* Metric Name */}
                <div className="mb-4">
                  <label htmlFor="metricName" className="block text-gray-700 text-sm font-bold mb-2">Metric Name:</label>
                  <input type="text" id="metricName" name="metricName" value={formData.metricName} onChange={handleChange} className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" />
                </div>
                {/* Timestamp (Datetime) */}
                <div className="mb-4">
                  <label htmlFor="timestamp" className="block text-gray-700 text-sm font-bold mb-2">Timestamp:</label>
                  <input type="datetime-local" id="timestamp" name="timestamp" value={formData.timestamp} onChange={handleChange} className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" />
                </div>
                {/* Numeric Value */}
                <div className="mb-4">
                  <label htmlFor="numericValue" className="block text-gray-700 text-sm font-bold mb-2">Value:</label>
                  <input type="number" id="value" name="value" value={formData.value} onChange={handleChange} className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" />
                </div>
                {/* Submit button */}
                <div className="flex items-center justify-end">
                  <button type="button" onClick={closeModal} className="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded mr-2">Cancel</button>
                  <button type="submit" className="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">Submit</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      )}
      <h1 className="text-2xl font-bold mb-4">{state.applicationName}</h1>
      <table className="min-w-full divide-y divide-gray-200">
        <thead className="bg-gray-50">
          <tr>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Metric name</th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">p99</th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">p95</th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">p50 (median)</th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">AVG</th>
          </tr>
        </thead>
        <tbody className="bg-white divide-y divide-gray-200">
          {data
            ? (
                data.map((item, index) => (
              <tr key={index} className="hover:bg-gray-100 cursor-pointer">
                <td className="px-6 py-4 whitespace-nowrap">
                  <Link to={`/applications/${id}/metrics/${item.metric_name}`} className="text-blue-500 hover:underline block">
                    {item.metric_name}
                  </Link>
                </td>
                <td className="px-6 py-4 whitespace-nowrap">{item.p99}</td>
                <td className="px-6 py-4 whitespace-nowrap">{item.p95}</td>
                <td className="px-6 py-4 whitespace-nowrap">{item.p50}</td>
                <td className="px-6 py-4 whitespace-nowrap">{item.avg}</td>
              </tr>
                ))
              )
            : (
            <tr>
              <td colSpan={3} className="px-6 py-4 text-center">Loading...</td>
            </tr>
              )}
        </tbody>
      </table>
    </div>
  )
}

export default ListApplicationMetrics
