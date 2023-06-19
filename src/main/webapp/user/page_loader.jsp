<!--loader-->
<div id="overlay">
    <div class="spinner-border text-white spinner" role="status">
        <span class="sr-only">Loading...</span>
    </div>
</div>
<style>
    #overlay {
        position: fixed;
        z-index: 999;
        top: 0;
        left: 0;
        bottom: 0;
        right: 0;
        background-color: rgba(0,0,0,0.5);
        /*display: flex;*/
        align-items: center;
        justify-content: center;
    }

    #overlay .spinner-border {
        width: 3rem;
        height: 3rem;
    }
</style>
<script>
    document.getElementById("overlay").style.display = "none";
    function showLoader() {
        document.getElementById("overlay").style.display = "flex";
    }
</script>