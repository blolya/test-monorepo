import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import { getRandomInt } from '../../libs/math';

export const handler = async (event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult> => {
    try {
        const response = {
            statusCode: 200,
            body: 'POST a lot of cars/ ' + getRandomInt(100) + ` with body ${JSON.stringify(event.body)}`
        };
        return response;
    } catch (err) {
        return {
            statusCode: 500,
            body: 'Internal Server Error',
        };
    }
};
