import axios, { AxiosResponse } from 'axios';
import moment from 'moment';

const BASE_URL = 'http://localhost:3000/api/v1';

export interface Application {
    id: string;
    name: string;
    created_at: string;
    updated_at: string;
}
  
export interface Meta {
    page: number;
    items: number;
    count: number;
}
  
export interface ListApplicationsResponse {
    records: Application[];
    meta: Meta;
}

export interface Metric {
    metric_name: string;
    p99: number;
    p95: number;
    p50: number;
    avg: number;
}

export interface MetricAggregatedData {
    date: string;
    count: number;
    p99: number;
    p95: number;
    p50: number;
    avg: number;
}

export const listApplicatios = async (page: number): Promise<ListApplicationsResponse> => {
  try {
    const response: AxiosResponse<ListApplicationsResponse> = await axios.get(`${BASE_URL}/applications?page=${page}`);
    return response.data;
  } catch (error) {
    console.error('Error fetching data:', error);
    throw error;
  }
};

export const listApplicatioMetrics = async (applicationId: string | undefined): Promise<Metric[]> => {
    try {
      const response: AxiosResponse<Metric[]> = await axios.get(`${BASE_URL}/applications/${applicationId}/metrics`);
      return response.data;
    } catch (error) {
      console.error('Error fetching data:', error);
      throw error;
    }
};
  
export const showMetricAggregatedData = async (applicationId: string | undefined, metricName: string | undefined, duration: string | undefined): Promise<MetricAggregatedData[]> => {
    try {
      const response: AxiosResponse<MetricAggregatedData[]> = await axios.get(`${BASE_URL}/applications/${applicationId}/metrics/${metricName}?duration=${duration}`);
      return response.data;
    } catch (error) {
      console.error('Error fetching data:', error);
      throw error;
    }
};


export const createApplicationMetricDataPoint = async (applicationId: string | undefined, data: {metricName: string, timestamp: string, value: string}): Promise<any> => {
  try {
    const response: AxiosResponse<any> = await axios.post(`${BASE_URL}/applications/${applicationId}/metrics`, {
      metrics: [
        {
          name: data.metricName,
          timestamp: moment(data.timestamp).unix(),
          value: Number(data.value),
        }
      ]
    });
    return response.data;
  } catch (error) {
    console.error('Error fetching data:', error);
    throw error;
  }
};

export const createApplication = async (name: string | undefined): Promise<any> => {
  try {
    const response: AxiosResponse<any> = await axios.post(`${BASE_URL}/applications`, {
      application: {
        name,
      }
    });
    return response.data;
  } catch (error) {
    console.error('Error fetching data:', error);
    throw error;
  }
};
