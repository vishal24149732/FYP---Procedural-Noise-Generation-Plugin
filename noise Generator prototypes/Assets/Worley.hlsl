#ifndef WORLEY_NOISE_INCLUDED
#define WORLEY_NOISE_INCLUDED


float2 RandomPoint(float2 cell)
{
    float x = frac(sin(dot(cell, float2(127.1, 311.7))) * 43758.5453);
    float y = frac(sin(dot(cell, float2(269.5, 183.3))) * 43758.5453);

    return float2(x, y);
}

void WorleyNoise_float(float2 UV, out float result)
{
    // Find the cell containing the current pixel
    float2 cell = floor(UV);

    // Position inside the cell
    float2 f = frac(UV);


    // Start with a very large distance
    float minDistance = 999999.0;


    for (int y = -1; y <= 1; y++)
    {
        for (int x = -1; x <= 1; x++)
        {
            // Neighbouring cell
            float2 neighbour = float2(x, y);

            // Position of neighbouring cell
            float2 neighbourCell = cell + neighbour;

            // Random feature point inside that cell
            float2 randomPoint = RandomPoint(neighbourCell);


            // Position of the feature point relative to the current pixel
            float2 Point = neighbour + randomPoint;

            // Distance between current pixel and feature point
            float distance = length(Point - f);


            // Keep the closest feature point
            minDistance = min(minDistance, distance);
        }
    }


    result = minDistance;
}


#endif