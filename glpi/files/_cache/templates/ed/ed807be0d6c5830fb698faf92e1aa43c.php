<?php

use Twig\Environment;
use Twig\Error\LoaderError;
use Twig\Error\RuntimeError;
use Twig\Extension\CoreExtension;
use Twig\Extension\SandboxExtension;
use Twig\Markup;
use Twig\Sandbox\SecurityError;
use Twig\Sandbox\SecurityNotAllowedTagError;
use Twig\Sandbox\SecurityNotAllowedFilterError;
use Twig\Sandbox\SecurityNotAllowedFunctionError;
use Twig\Source;
use Twig\Template;

/* pages/login_error.html.twig */
class __TwigTemplate_59007f3fe62f1874602ec08683e6757a extends Template
{
    private $source;
    private $macros = [];

    public function __construct(Environment $env)
    {
        parent::__construct($env);

        $this->source = $this->getSourceContext();

        $this->blocks = [
            'content_block' => [$this, 'block_content_block'],
        ];
    }

    protected function doGetParent(array $context)
    {
        // line 34
        return "layout/page_card_notlogged.html.twig";
    }

    protected function doDisplay(array $context, array $blocks = [])
    {
        $macros = $this->macros;
        $this->parent = $this->loadTemplate("layout/page_card_notlogged.html.twig", "pages/login_error.html.twig", 34);
        yield from $this->parent->unwrap()->yield($context, array_merge($this->blocks, $blocks));
    }

    // line 36
    public function block_content_block($context, array $blocks = [])
    {
        $macros = $this->macros;
        // line 37
        yield "<div class=\"alert alert-warning\">
    <div class=\"d-flex align-items-center\">
        <div class=\"me-4\">
            <i class=\"ti ti-alert-triangle fa-2x\"></i>
        </div>
        <div>
            <h4 class=\"alert-title\">
                ";
        // line 44
        yield $this->env->getRuntime('Twig\Runtime\EscaperRuntime')->escape(__("Error"), "html", null, true);
        yield "
            </h4>
            <div>
                ";
        // line 47
        $context['_parent'] = $context;
        $context['_seq'] = CoreExtension::ensureTraversable(($context["errors"] ?? null));
        foreach ($context['_seq'] as $context["_key"] => $context["error"]) {
            // line 48
            yield "                    ";
            yield $this->env->getRuntime('Twig\Runtime\EscaperRuntime')->escape($context["error"], "html", null, true);
            yield "<br />
                ";
        }
        $_parent = $context['_parent'];
        unset($context['_seq'], $context['_iterated'], $context['_key'], $context['error'], $context['_parent'], $context['loop']);
        $context = array_intersect_key($context, $_parent) + $_parent;
        // line 50
        yield "            </div>

            <a href=\"";
        // line 52
        yield $this->env->getRuntime('Twig\Runtime\EscaperRuntime')->escape(($context["login_url"] ?? null), "html", null, true);
        yield "\" class=\"btn btn-primary mt-3\">
                <i class=\"ti ti-login\"></i>
                <span>";
        // line 54
        yield $this->env->getRuntime('Twig\Runtime\EscaperRuntime')->escape(__("Log in again"), "html", null, true);
        yield "</span>
            </a>
        </div>
    </div>
</div>
";
        return; yield '';
    }

    /**
     * @codeCoverageIgnore
     */
    public function getTemplateName()
    {
        return "pages/login_error.html.twig";
    }

    /**
     * @codeCoverageIgnore
     */
    public function isTraitable()
    {
        return false;
    }

    /**
     * @codeCoverageIgnore
     */
    public function getDebugInfo()
    {
        return array (  88 => 54,  83 => 52,  79 => 50,  70 => 48,  66 => 47,  60 => 44,  51 => 37,  47 => 36,  36 => 34,);
    }

    public function getSourceContext()
    {
        return new Source("", "pages/login_error.html.twig", "/var/www/html/templates/pages/login_error.html.twig");
    }
}
