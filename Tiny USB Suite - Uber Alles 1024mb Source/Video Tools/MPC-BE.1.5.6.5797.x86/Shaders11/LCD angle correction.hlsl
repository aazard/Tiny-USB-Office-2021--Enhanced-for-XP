// $MinimumShaderProfile: ps_4_0

// (C) 2011 Jan-Willem Krans (janwillem32 <at> hotmail.com) released under GPL v2; see COPYING.txt

// Brightness, contrast and gamma controls for RGB, linearly scaled from top to bottom.
// This shader can be run as a screen space pixel shader. It requires compiling with ps_2_0,
// but higher is better see http://en.wikipedia.org/wiki/Pixel_shader to look up what PS version
// your video card supports.
// This shader is meant to work with linear RGB input and output. Regular R'G'B' with
// a video gamma encoding will have to be converted with the linear gamma shaders to work properly.

// Fractions, either decimal or not, are allowed
// RedBrightness, GreenBrightness and BlueBrightness, interval [-10, 10], default 0
#define RedBrightnessTop 0
#define GreenBrightnessTop 0
#define BlueBrightnessTop 0
#define RedBrightnessBottom 0
#define GreenBrightnessBottom 0
#define BlueBrightnessBottom 0

// RedContrast, GreenContrast and BlueContrast, interval [0, 10], default 1
#define RedContrastTop 1
#define GreenContrastTop 1
#define BlueContrastTop 1
#define RedContrastBottom 1
#define GreenContrastBottom 1
#define BlueContrastBottom 1

// RedGamma, GreenGamma and BlueGamma, interval (0, 10], default 1
#define RedGammaTop 0.8
#define GreenGammaTop 0.8
#define BlueGammaTop 0.8
#define RedGammaBottom 1
#define GreenGammaBottom 1
#define BlueGammaBottom 1

Texture2D tex : register(t0);
SamplerState samp : register(s0);

float4 main(float4 pos : SV_POSITION, float2 coord : TEXCOORD) : SV_Target
{
	float3 s1 = tex.Sample(samp, coord).rgb;
	// original pixel
	float coordyi = 1.0 - coord.y;
	s1 = s1 * (coordyi * float3(RedContrastTop, GreenContrastTop, BlueContrastTop) + coord.y * float3(RedContrastBottom, GreenContrastBottom, BlueContrastBottom)) + coordyi * float3(RedBrightnessTop, GreenBrightnessTop, BlueBrightnessTop) + coord.y * float3(RedBrightnessBottom, GreenBrightnessBottom, BlueBrightnessBottom);
	// process contrast and brightness on the original pixel
	// preserve the sign bits of RGB values
	float3 sb = sign(s1);
	return (sb*pow(abs(s1), coordyi * float3(RedGammaTop, GreenGammaTop, BlueGammaTop) + coord.y * float3(RedGammaBottom, GreenGammaBottom, BlueGammaBottom))).rgbb;
	// process gamma correction and output
}
