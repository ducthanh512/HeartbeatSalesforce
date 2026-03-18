<aura:application access="global" extends="force:slds">
    <div class="slds-grid slds-wrap slds-gutters slds-p-around_large" style="background:#f3f2f2; min-height:100vh;">

        <div class="slds-col slds-size_1-of-1 slds-m-bottom_medium">
            <h1 style="font-size:1.5rem;font-weight:700;color:#032d60;text-align:center;">
                ⚡ Lightning Component Preview
            </h1>
        </div>

        <!-- Heartbeat -->
        <div class="slds-col slds-size_1-of-1 slds-medium-size_1-of-2 slds-p-around_small">
            <div class="slds-card">
                <div class="slds-card__header slds-grid">
                    <h2 class="slds-card__header-title">
                        <span>Heartbeat Component</span>
                    </h2>
                </div>
                <div class="slds-card__body slds-card__body_inner">
                    <c:heartbeat />
                </div>
            </div>
        </div>

        <!-- Wolf -->
        <div class="slds-col slds-size_1-of-1 slds-medium-size_1-of-2 slds-p-around_small">
            <div class="slds-card">
                <div class="slds-card__header slds-grid">
                    <h2 class="slds-card__header-title">
                        <span>Wolf Component</span>
                    </h2>
                </div>
                <div class="slds-card__body slds-card__body_inner">
                    <c:wolf />
                </div>
            </div>
        </div>

    </div>
</aura:application>
