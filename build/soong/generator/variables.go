package generator

import (
	"fmt"

	"android/soong/android"
)

func apexExpandVariables(ctx android.ModuleContext, in string) string {
	apexVars := ctx.Config().VendorConfig("apexVarsPlugin")

	out, err := android.Expand(in, func(name string) (string, error) {
		if apexVars.IsSet(name) {
			return apexVars.String(name), nil
		}
		// This variable is not for us, restore what the original
		// variable string will have looked like for an Expand
		// that comes later.
		return fmt.Sprintf("$(%s)", name), nil
	})

	if err != nil {
		ctx.PropertyErrorf("%s: %s", in, err.Error())
		return ""
	}

	return out
}