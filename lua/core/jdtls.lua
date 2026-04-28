local jdtls = require("jdtls")
local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
local jdtls_path = mason_path .. "/jdtls"

local bundles = {
  mason_path .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.53.2.jar",
}

local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local config = {
  cmd = {
    "/Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home/bin/java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", jdtls_path .. "/plugins/org.eclipse.equinox.launcher_1.7.100.v20251111-0406.jar",
    "-configuration", jdtls_path .. "/config_mac_arm",
    "-data", workspace_dir,
  },
  root_dir = jdtls.setup.find_root({ "pom.xml", "build.gradle", ".git" }),
  settings = {
    java = {
      configuration = {
        runtimes = {
			{ name = "JavaSE-1.8", path = "/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home" },
			{ name = "JavaSE-17", path = "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home" },
			{ name = "JavaSE-21", path = "/Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home" },
        },
      },
    },
  },
  init_options = {
    bundles = bundles,
  },
  on_attach = function()
    jdtls.setup_dap({ hotcodereplace = "auto" })
  end,
}

return {
    setup = function()
        jdtls.start_or_attach(config)
    end
}
