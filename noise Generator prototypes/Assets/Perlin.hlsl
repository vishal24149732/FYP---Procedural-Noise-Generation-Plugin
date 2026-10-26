#ifndef PERLIN_NOISE_INCLUDED
#define PERLIN_NOISE_INCLUDED



float RandomValue(float2 p)
{
    return frac(sin(dot(p, float2(127.1, 311.7))) * 43758.5453);
}

float2 GetGradient(float h)
{
    if (h < 0.25)
        return float2(1, 0);
    else if (h < 0.5)
        return float2(-1, 0);
    else if (h < 0.75)
        return float2(0, 1);
    else
        return float2(0, -1);
}

void PerlinNoise_float(float2 UV, out float result)
{
    // Find grid cell
    float2 cell = floor(UV);

    // Position inside the cell
    float2 f = frac(UV);

    float2 c00 = cell;
    float2 c10 = cell + float2(1, 0);
    float2 c01 = cell + float2(0, 1);
    float2 c11 = cell + float2(1, 1);

  

    float h00 = RandomValue(c00);
    float h10 = RandomValue(c10);
    float h01 = RandomValue(c01);
    float h11 = RandomValue(c11);




    float2 g00 = GetGradient(h00);
    float2 g10 = GetGradient(h10);
    float2 g01 = GetGradient(h01);
    float2 g11 = GetGradient(h11);

    float2 d00 = f;
    float2 d10 = f - float2(1, 0);
    float2 d01 = f - float2(0, 1);
    float2 d11 = f - float2(1, 1);

    float n00 = dot(g00, d00);
    float n10 = dot(g10, d10);
    float n01 = dot(g01, d01);
    float n11 = dot(g11, d11);

    float u = f.x * f.x * f.x *
              (f.x * (f.x * 6 - 15) + 10);

    float v = f.y * f.y * f.y *
              (f.y * (f.y * 6 - 15) + 10);


    float bottom = lerp(n00, n10, u);
    float top = lerp(n01, n11, u);

    float value = lerp(bottom, top, v);


    result = value * 0.5 + 0.5;
}


#endif