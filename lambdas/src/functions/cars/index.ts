import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import { getRandomInt } from '../../libs/math';

export const handler = async (_event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult> => {
    try {
        const response = {
            statusCode: 200,
            body: 'GET many cars/ ' + getRandomInt(100),
        };
        return response;
    } catch (err) {
        return {
            statusCode: 500,
            body: 'Internal Server Error',
        };
    }
};
