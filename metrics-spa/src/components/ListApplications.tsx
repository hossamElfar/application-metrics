import React, { useState, useEffect } from 'react';
import { listApplicatios, ListApplicationsResponse, createApplication } from '../api';
import { Link } from 'react-router-dom';

const ListApplications: React.FC = () => {
  const [data, setData] = useState<ListApplicationsResponse | null>(null);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [error, setError] = useState(null);
  const [successMessage, setSuccessMessage] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage] = useState(10);
  const [totalItems, setTotalItems] = useState(0);

  const [formData, setFormData] = useState({
    name: '',
  });

  const openModal = () => {
    setIsModalOpen(true);
  };

  const closeModal = () => {
    setIsModalOpen(false);
    setError(null);
    setSuccessMessage(null);
  };

  const handleChange = (e: any) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = async (e: any) => {
    e.preventDefault();
    try {
      await createApplication(formData.name);
      setIsModalOpen(false);
      setSuccessMessage('Application created successfully.');
      setFormData({
        name: '',
      })
      setTimeout(() => {
        setSuccessMessage(null);
      }, 10000);
      const result = await listApplicatios(1);
      setCurrentPage(1);
      setData(result);
    } catch (error: any) {
      console.error('Error creating application:', error);
      setError(error.response?.data?.message);
    }
  };

  const handlePageChange = (pageNumber: number) => {
    setCurrentPage(pageNumber);
  };

  useEffect(() => {
    const fetchDataFromApi = async () => {
      try {
        const result = await listApplicatios(currentPage);
        setData(result);
        setTotalItems(result.meta.count);
      } catch (error) {
        console.error(error);
      }
    };

    fetchDataFromApi();
  }, [currentPage, itemsPerPage]);

  const totalPages = Math.ceil(totalItems / itemsPerPage);

  return (
    <div className="container mx-auto mt-8">
      {/* Button to open modal */}
      <button onClick={openModal} className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
        Create Application
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
                
                {/* Application Name */}
                <div className="mb-4">
                  <label htmlFor="name" className="block text-gray-700 text-sm font-bold mb-2">Application Name:</label>
                  <input type="text" id="name" name="name" value={formData.name} onChange={handleChange} className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" />
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

      <h1 className="text-2xl font-bold mb-4">Available applications</h1>
      <table className="min-w-full divide-y divide-gray-200">
        <thead className="bg-gray-50">
          <tr>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Created At</th>
          </tr>
        </thead>
        <tbody className="bg-white divide-y divide-gray-200">
          {data ? (
            data.records.map((item, index) => (
              <tr key={index} className="hover:bg-gray-100 cursor-pointer">
                <td className="px-6 py-4 whitespace-nowrap">
                  <Link to={`/applications/${item.id}`} className="text-blue-500 hover:underline block">
                    {item.name}
                  </Link>
                </td>
                <td className="px-6 py-4 whitespace-nowrap">{item.created_at}</td>
              </tr>
            ))
          ) : (
            <tr>
              <td colSpan={3} className="px-6 py-4 text-center">Loading...</td>
            </tr>
          )}
        </tbody>
      </table>
      {/* Pagination */}
      <div className="fixed bottom-0 left-0 w-full bg-white py-4 shadow-lg flex justify-center">
        <nav>
          <ul className="pagination flex">
            {/* Previous page button */}
            <li className={`pagination-item ${currentPage === 1 ? 'disabled' : ''}`}>
              <button onClick={() => handlePageChange(currentPage - 1)} disabled={currentPage === 1} className="bg-gray-200 hover:bg-gray-300 text-gray-800 font-bold py-2 px-4 rounded-l">
                &#8592;
              </button>
            </li>

            {/* Page numbers */}
            {Array.from({ length: totalPages }, (_, index) => (
              <li key={index} className={`pagination-item ${currentPage === index + 1 ? 'active' : ''}`}>
                <button onClick={() => handlePageChange(index + 1)} className="bg-gray-200 hover:bg-gray-300 text-gray-800 font-bold py-2 px-4 rounded">
                  {index + 1}
                </button>
              </li>
            ))}

            {/* Next page button */}
            <li className={`pagination-item ${currentPage === totalPages ? 'disabled' : ''}`}>
              <button onClick={() => handlePageChange(currentPage + 1)} disabled={currentPage === totalPages} className="bg-gray-200 hover:bg-gray-300 text-gray-800 font-bold py-2 px-4 rounded-r">
                &#8594;
              </button>
            </li>
          </ul>
        </nav>
      </div>
    </div>
  );
};

export default ListApplications;
