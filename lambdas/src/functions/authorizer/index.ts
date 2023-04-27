import { APIGatewayRequestAuthorizerEvent, APIGatewaySimpleAuthorizerWithContextResult, APIGatewayProxyResult } from 'aws-lambda';

export const handler = async (event: APIGatewayRequestAuthorizerEvent): Promise<APIGatewaySimpleAuthorizerWithContextResult<APIGatewayProxyResult>> => {
    const headers = event.headers;
    if (!headers) return {
        isAuthorized: false,
        context: {
            statusCode: 401,
            body: 'No credentials'
        }
    }
    const userId = headers['user-id'];
    const requestToken = headers['request-token'];
    if (!userId || !requestToken) return {
        isAuthorized: false,
        context: {
            statusCode: 401,
            body: 'No credentials'
        }
    }

    const webflowAuthToken = process.env.WEBFLOW_AUTH_TOKEN;
    const siteId = process.env.SITE_ID;

    const userResponse = await fetch(`https://api.webflow.com/sites/${siteId}/users/${userId}`, {
        method: 'GET',
        headers: {
            'accept': 'application/json',
            'authorization': `Bearer ${webflowAuthToken}`
        }
    })

    const user = await userResponse.json();
    const token = user.data['session-token'];

    if (requestToken !== token) return {
        isAuthorized: false,
        context: {
            statusCode: 403,
            body: 'Wrong credentials'
        }
    }

     return {
        isAuthorized: true,
        context: {
            statusCode: 200,
            body: 'Success'
        }
    };
};
