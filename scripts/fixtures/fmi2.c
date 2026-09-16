/* Minimal FMI 2 model used only to generate reader fixtures: dx/dt = -x. */
#include <stdlib.h>
#include "fmi2Functions.h"

fmi2Component fmi2Instantiate(fmi2String name, fmi2Type type, fmi2String guid,
    fmi2String location, const fmi2CallbackFunctions *callbacks,
    fmi2Boolean visible, fmi2Boolean logging) {
    double *x = (double *)calloc(1, sizeof(double));
    if (x) *x = 1;
    return x;
}
void fmi2FreeInstance(fmi2Component c) { free(c); }
fmi2Status fmi2Reset(fmi2Component c) { *(double *)c = 1; return fmi2OK; }
fmi2Status fmi2SetupExperiment(fmi2Component c, fmi2Boolean toleranceDefined,
    fmi2Real tolerance, fmi2Real startTime, fmi2Boolean stopTimeDefined,
    fmi2Real stopTime) { return fmi2OK; }
fmi2Status fmi2EnterInitializationMode(fmi2Component c) { return fmi2OK; }
fmi2Status fmi2ExitInitializationMode(fmi2Component c) { return fmi2OK; }
fmi2Status fmi2EnterContinuousTimeMode(fmi2Component c) { return fmi2OK; }
fmi2Status fmi2SetTime(fmi2Component c, fmi2Real time) { return fmi2OK; }
fmi2Status fmi2GetDerivatives(fmi2Component c, fmi2Real derivatives[], size_t nx) {
    for (size_t i=0; i<nx; ++i) derivatives[i] = -*(double *)c;
    return fmi2OK;
}
fmi2Status fmi2SetReal(fmi2Component c, const fmi2ValueReference vr[], size_t n,
    const fmi2Real values[]) {
    for (size_t i=0; i<n; ++i) if (vr[i]==0) *(double *)c = values[i];
    return fmi2OK;
}
fmi2Status fmi2GetReal(fmi2Component c, const fmi2ValueReference vr[], size_t n,
    fmi2Real values[]) {
    for (size_t i=0; i<n; ++i) values[i] = vr[i]==0 ? *(double *)c : -*(double *)c;
    return fmi2OK;
}
#define ACCESSORS(Name, Type, Default) \
fmi2Status fmi2Get##Name(fmi2Component c, const fmi2ValueReference vr[], \
    size_t n, Type values[]) { \
    for (size_t i=0; i<n; ++i) values[i]=Default; return fmi2OK; \
} \
fmi2Status fmi2Set##Name(fmi2Component c, const fmi2ValueReference vr[], \
    size_t n, const Type values[]) { return fmi2OK; }
ACCESSORS(Integer, fmi2Integer, 0)
ACCESSORS(Boolean, fmi2Boolean, fmi2False)
ACCESSORS(String, fmi2String, "")
fmi2Status fmi2NewDiscreteStates(fmi2Component c, fmi2EventInfo *info) {
    *info = (fmi2EventInfo){0};
    return fmi2OK;
}
